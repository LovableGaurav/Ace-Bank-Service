package com.acebank.lite.models;

import java.sql.Timestamp;

public record PasswordResetOtp(
        String email,
        int accountNo,
        String otpHash,
        Timestamp expiresAt,
        int attempts,
        boolean used
) {
}

