package com.vov.adapter.config;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.security.web.SecurityFilterChain;

/**
 * Validates access tokens issued by Supabase Auth.
 *
 * Supabase should be configured with an asymmetric signing key and its JWKS
 * endpoint supplied through SUPABASE_JWK_SET_URI. The issuer and audience are
 * checked in addition to the JWT signature and expiry.
 */
@Configuration
@EnableMethodSecurity
public class SupabaseSecurityConfig {

    @Bean
    SecurityFilterChain securityFilterChain(
            HttpSecurity http,
            Converter<Jwt, ? extends AbstractAuthenticationToken> jwtAuthenticationConverter)
            throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .cors(cors -> {})
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers(request -> "OPTIONS".equalsIgnoreCase(request.getMethod())).permitAll()
                        .requestMatchers("/actuator/health", "/error").permitAll()
                        .anyRequest().authenticated())
                .oauth2ResourceServer(oauth2 -> oauth2
                        .jwt(jwt -> jwt.jwtAuthenticationConverter(jwtAuthenticationConverter)));
        return http.build();
    }

    @Bean
    JwtDecoder jwtDecoder(
            @Value("${security.supabase.issuer-uri}") String issuer,
            @Value("${security.supabase.jwk-set-uri}") String jwkSetUri,
            @Value("${security.supabase.jwt-secret:}") String jwtSecret,
            @Value("${security.supabase.audience:authenticated}") String audience) {
        if (issuer == null || issuer.isBlank()) {
            throw new IllegalStateException("SUPABASE_ISSUER_URI must be configured");
        }

        NimbusJwtDecoder decoder;
        if (jwkSetUri != null && !jwkSetUri.isBlank()) {
            decoder = NimbusJwtDecoder.withJwkSetUri(jwkSetUri).build();
        } else if (jwtSecret != null && !jwtSecret.isBlank()) {
            decoder = NimbusJwtDecoder.withSecretKey(
                    new SecretKeySpec(jwtSecret.getBytes(StandardCharsets.UTF_8), "HmacSHA256")).build();
        } else {
            throw new IllegalStateException(
                    "Either SUPABASE_JWK_SET_URI (recommended) or SUPABASE_JWT_SECRET must be configured");
        }
        decoder.setJwtValidator(new AudienceAndIssuerValidator(issuer, audience));
        return decoder;
    }

    @Bean
    Converter<Jwt, ? extends AbstractAuthenticationToken> jwtAuthenticationConverter() {
        return jwt -> new JwtAuthenticationToken(jwt, authoritiesFrom(jwt), jwt.getSubject());
    }

    private static Collection<GrantedAuthority> authoritiesFrom(Jwt jwt) {
        List<GrantedAuthority> authorities = new ArrayList<>();
        addAuthorities(authorities, jwt.getClaims().get("role"));
        addAuthorities(authorities, jwt.getClaims().get("roles"));
        Object appMetadata = jwt.getClaims().get("app_metadata");
        if (appMetadata instanceof Map<?, ?> metadata) {
            addAuthorities(authorities, metadata.get("roles"));
        }
        return authorities;
    }

    private static void addAuthorities(List<GrantedAuthority> authorities, Object value) {
        if (value instanceof Collection<?> values) {
            values.forEach(item -> addAuthority(authorities, item));
        } else {
            addAuthority(authorities, value);
        }
    }

    private static void addAuthority(List<GrantedAuthority> authorities, Object value) {
        if (value != null && !String.valueOf(value).isBlank()) {
            authorities.add(new SimpleGrantedAuthority("ROLE_" + value));
        }
    }
}
