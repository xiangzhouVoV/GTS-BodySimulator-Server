-- Macro Calculator 首期常见国家种子数据。
-- 使用 UPSERT 保证脚本可重复执行，并允许修正国家名称或 locale。

INSERT INTO public.countries (country_code, name_en, name_local, locale, is_active)
VALUES
    ('CN', 'China', '中国', 'zh-CN', TRUE),
    ('US', 'United States', 'United States', 'en-US', TRUE),
    ('IN', 'India', 'भारत', 'hi-IN', TRUE),
    ('JP', 'Japan', '日本', 'ja-JP', TRUE),
    ('KR', 'South Korea', '대한민국', 'ko-KR', TRUE),
    ('GB', 'United Kingdom', 'United Kingdom', 'en-GB', TRUE),
    ('MX', 'Mexico', 'México', 'es-MX', TRUE),
    ('BR', 'Brazil', 'Brasil', 'pt-BR', TRUE),
    ('CA', 'Canada', 'Canada', 'en-CA', TRUE),
    ('AU', 'Australia', 'Australia', 'en-AU', TRUE),
    ('NZ', 'New Zealand', 'New Zealand', 'en-NZ', TRUE),
    ('SG', 'Singapore', 'Singapore', 'en-SG', TRUE),
    ('MY', 'Malaysia', 'Malaysia', 'ms-MY', TRUE),
    ('ID', 'Indonesia', 'Indonesia', 'id-ID', TRUE),
    ('TH', 'Thailand', 'ประเทศไทย', 'th-TH', TRUE),
    ('VN', 'Vietnam', 'Việt Nam', 'vi-VN', TRUE),
    ('PH', 'Philippines', 'Pilipinas', 'en-PH', TRUE),
    ('FR', 'France', 'France', 'fr-FR', TRUE),
    ('DE', 'Germany', 'Deutschland', 'de-DE', TRUE),
    ('IT', 'Italy', 'Italia', 'it-IT', TRUE),
    ('ES', 'Spain', 'España', 'es-ES', TRUE),
    ('NL', 'Netherlands', 'Nederland', 'nl-NL', TRUE),
    ('RU', 'Russia', 'Россия', 'ru-RU', TRUE),
    ('TR', 'Turkey', 'Türkiye', 'tr-TR', TRUE),
    ('SA', 'Saudi Arabia', 'المملكة العربية السعودية', 'ar-SA', TRUE),
    ('AE', 'United Arab Emirates', 'الإمارات العربية المتحدة', 'ar-AE', TRUE),
    ('ZA', 'South Africa', 'South Africa', 'en-ZA', TRUE),
    ('CH', 'Switzerland', 'Schweiz', 'de-CH', TRUE),
    ('SE', 'Sweden', 'Sverige', 'sv-SE', TRUE),
    ('AR', 'Argentina', 'Argentina', 'es-AR', TRUE)
ON CONFLICT (country_code) DO UPDATE SET
    name_en = EXCLUDED.name_en,
    name_local = EXCLUDED.name_local,
    locale = EXCLUDED.locale,
    is_active = EXCLUDED.is_active;
