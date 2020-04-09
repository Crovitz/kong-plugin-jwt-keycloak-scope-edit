local function validate_scope(allowed_scopes, jwt_claims)
    if allowed_scopes == nil or table.getn(allowed_scopes) == 0 then
        return true
    end

    if jwt_claims == nil or jwt_claims.authorization == nil then
        return nil, "Missing required authorization claim"
    end

    for _, curr_scope in pairs(allowed_scopes) do
        for _, permission in pairs(jwt_claims.authorization.permissions) do
            for _, scope in pairs(permission.scopes) do
                if curr_scope == scope then
                    return true
                end
            end
        end    
    end
    return nil, "Missing required scope"
end

return {
    validate_scope = validate_scope
}