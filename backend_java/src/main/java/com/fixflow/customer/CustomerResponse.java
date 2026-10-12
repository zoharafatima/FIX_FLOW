package com.fixflow.customer;

import java.time.LocalDateTime;

public record CustomerResponse(
        Integer customerId,
        String name,
        String email,
        String phone,
        String address,
        String city,
        LocalDateTime createdAt) {
}