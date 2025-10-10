package com.sajikitchen.saji_cashier.dto.admin;

import lombok.Data;

import java.util.UUID;

@Data
public class CreateUserRequestDto {
    private String username;
    private String password;
    private UUID roleId;
}