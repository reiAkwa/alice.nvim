-- alice 主题色板：variant -> { background, colors, terminal }
--
-- colors 里每个角色是 { '#RRGGBB', cterm256 }，cterm 可省略（按最接近的 xterm-256 换算）；
-- 也可以写成另一个角色名表示别名，例如 sunny 的 search_fg = 'on_accent'。
-- lua/alice/groups.lua 只引用角色名，所以新增主题 = 在这里加一张色板，
-- 修改一条规则 = 三套主题同时生效。
--
-- 角色名与 magic-doll 家族 token（magic-doll-vibe）的对应：
--   bg→bg1        panel→bg2      fg→txt1        on_accent→txt2
--   accent→acc1   steel→acc2     purple→acc3
--   green→str     orange→num     muted→comm     warn→warn     red→err
--   faint→gray    pale_yellow→yellow            magenta→magenta   cyan→cyan
--   pink_bg→red（终端红，作用于 insert 模式色块）
-- 以下角色是家族色相压深/提亮派生出的 Neovim 专用色，家族 token 里没有：
--   search_fg / search_bg / diff_add_bg / diff_change_bg / diff_delete_bg / matchparen_bg

return {
  sunny = {
    background = 'light',
    colors = {
      bg             = { '#F0F8FF', 231 },
      panel          = { '#DAE2E9', 254 },
      faint          = { '#A8B4C0', 249 },
      fg             = { '#3B3B3B', 237 },
      on_accent      = { '#1F2F3A', 236 },
      muted          = { '#787878', 243 },
      steel          = { '#5B7F92', 66 },
      accent         = { '#56A0D1', 74 },
      warn           = { '#B58532', 137 },
      green          = { '#4F7A6A', 65 },
      red            = { '#A56A83', 132 },
      purple         = { '#8868AE', 97 },
      orange         = { '#A57A2E', 136 },
      cyan           = { '#789EB1', 109 },
      magenta        = { '#CBA0E3', 182 },
      pale_yellow    = { '#CFB886', 180 },
      search_fg      = 'on_accent', -- 浅底上直接用墨色（沿用原手写稿）
      search_bg      = { '#DDCCA7', 187 },
      diff_add_bg    = { '#A2B8AF', 145 },
      diff_change_bg = { '#A0B2BC', 145 },
      diff_delete_bg = { '#D9B8C5', 182 },
      matchparen_bg  = { '#BEDCD0', 152 },
      pink_bg        = { '#C998AE', 175 },
    },
    terminal = {
      '#1F2F3A', '#C998AE', '#7FAD9C', '#CFB886', '#56A0D1', '#CBA0E3', '#789EB1', '#A8B4C0',
      '#2E4250', '#DC8AB1', '#59B698', '#D8B260', '#2EA2E5', '#CC97F3', '#56A3C4', '#BAC6D1',
    },
  },

  rainy = {
    background = 'dark',
    colors = {
      bg             = { '#1F252A', 235 },
      panel          = { '#30363C', 237 },
      faint          = { '#3D454D', 238 },
      fg             = { '#CCD2D7', 252 },
      on_accent      = { '#EEF2F6', 255 },
      muted          = { '#8F9396', 246 },
      steel          = { '#5B7F92', 66 },
      accent         = { '#56A0D1', 74 },
      warn           = { '#C49A55', 173 },
      green          = { '#65B095', 72 },
      red            = { '#BA829A', 138 },
      purple         = { '#A280CB', 140 },
      orange         = { '#BFA065', 143 },
      cyan           = { '#71B6C9', 74 },
      magenta        = { '#B88FD5', 140 },
      pale_yellow    = { '#D0AE68', 179 },
      search_fg      = { '#1A2026', 234 },
      search_bg      = { '#6D5625', 58 },
      diff_add_bg    = { '#225242', 237 },
      diff_change_bg = { '#243A46', 237 },
      diff_delete_bg = { '#553443', 238 },
      matchparen_bg  = { '#487664', 65 },
      pink_bg        = { '#D19AB0', 175 },
    },
    terminal = {
      '#1A2026', '#D19AB0', '#71C0A2', '#D0AE68', '#56A0D1', '#B88FD5', '#71B6C9', '#3D454D',
      '#39414A', '#E0B3C4', '#8ED4B8', '#E2C284', '#7DB8E0', '#CBA7E4', '#93CCDD', '#E8EDF2',
    },
  },

  nightly = {
    background = 'dark',
    colors = {
      bg             = { '#090E12', 233 },
      panel          = { '#161B20', 234 },
      faint          = { '#232D35', 236 },
      fg             = { '#E0E5EA', 254 },
      on_accent      = { '#F6F9FB', 231 },
      muted          = { '#8F9396', 246 },
      steel          = { '#5B7F92', 66 },
      accent         = { '#56A0D1', 74 },
      warn           = { '#D7A03D', 179 },
      green          = { '#50BF9B', 72 },
      red            = { '#CF84A5', 175 },
      purple         = { '#A280CB', 140 },
      orange         = { '#D2A652', 179 },
      cyan           = { '#69B6CC', 74 },
      magenta        = { '#B591D4', 140 },
      pale_yellow    = { '#D9AE55', 179 },
      search_fg      = { '#0D1419', 233 },
      search_bg      = { '#735613', 58 },
      diff_add_bg    = { '#055843', 23 },
      diff_change_bg = { '#203642', 236 },
      diff_delete_bg = { '#5F3246', 238 },
      matchparen_bg  = { '#3F7C67', 65 },
      pink_bg        = { '#D99FB5', 181 },
    },
    terminal = {
      '#0D1419', '#D99FB5', '#5FC7A5', '#D9AE55', '#56A0D1', '#B591D4', '#69B6CC', '#232D35',
      '#202A33', '#E9B6C9', '#7FD6B7', '#ECC16F', '#7EB9E0', '#CFA9E8', '#92CFDF', '#F0F5F8',
    },
  },
}
