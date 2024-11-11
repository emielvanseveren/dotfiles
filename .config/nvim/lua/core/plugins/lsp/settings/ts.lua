-- TODO: single quote
return {
  javascript = {
    inlayHints = {
      includeInlayEnumMemberValueHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayVariableTypeHints = true,
    },
  },
  typescript = {
    inlayHints = {
      includeInlayEnumMemberValueHints =  false,
      includeInlayFunctionLikeReturnTypeHints = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayParameterNameHints = "none", -- 'none' | 'literals' | 'all';
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayPropertyDeclarationTypeHints = false,
      includeInlayVariableTypeHints = true,
    },
  },
}
