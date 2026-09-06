package com.sean.adapter.config;

import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.oauth2.core.OAuth2TokenValidator;
import org.springframework.security.oauth2.core.OAuth2TokenValidatorResult;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtValidators;

/** Adds the Supabase audience check to the standard issuer/time validation. */
final class AudienceAndIssuerValidator implements OAuth2TokenValidator<Jwt> {
    private final OAuth2TokenValidator<Jwt> delegate;
    private final String audience;

    AudienceAndIssuerValidator(String issuer, String audience) {
        this.delegate = JwtValidators.createDefaultWithIssuer(issuer);
        this.audience = audience;
    }

    @Override
    public OAuth2TokenValidatorResult validate(Jwt token) {
        OAuth2TokenValidatorResult result = delegate.validate(token);
        if (result.hasErrors()) {
            return result;
        }
        return token.getAudience().contains(audience)
                ? OAuth2TokenValidatorResult.success()
                : OAuth2TokenValidatorResult.failure(new OAuth2Error(
                        "invalid_token", "The required audience is missing", null));
    }
}
