package com.sajikitchen.saji_cashier.dto.admin;

import lombok.Builder;
import lombok.Data;

import java.util.UUID;

@Data
@Builder
public class RoleResponseDto {
    private UUID roleId;
    private String roleName;
}