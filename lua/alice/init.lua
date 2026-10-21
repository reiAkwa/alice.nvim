-- alice 主题加载器：色板(lua/alice/palette.lua) × 规格(lua/alice/groups.lua) -> highlight 组
--
-- 对外只有一个入口：require('alice').load('sunny' | 'rainy' | 'nightly')，
-- colors/alice-*.lua 就是两行调用它的壳。

local palette = require('alice.palette')
local spec = require('alice.groups')

local M = {}

-- 可用主题全名（供主题切换器 / 补全使用）
M.names = {}
for key in pairs(palette) do
  M.names[#M.names + 1] = 'alice-' .. key
end
table.sort(M.names)

-- xterm-256 调色板，仅在色板条目省略 cterm 时用于换算近似色
local xterm = {}
do
  local base = {
    { 0, 0, 0 }, { 128, 0, 0 }, { 0, 128, 0 }, { 128, 128, 0 },
    { 0, 0, 128 }, { 128, 0, 128 }, { 0, 128, 128 }, { 192, 192, 192 },
    { 128, 128, 128 }, { 255, 0, 0 }, { 0, 255, 0 }, { 255, 255, 0 },
    { 0, 0, 255 }, { 255, 0, 255 }, { 0, 255, 255 }, { 255, 255, 255 },
  }
  for i, rgb in ipairs(base) do
    xterm[i - 1] = rgb
  end
  local levels, i = { 0, 95, 135, 175, 215, 255 }, 16
  for _, r in ipairs(levels) do
    for _, g in ipairs(levels) do
      for _, b in ipairs(levels) do
        xterm[i], i = { r, g, b }, i + 1
      end
    end
  end
  for step = 0, 23 do
    local v = 8 + step * 10
    xterm[232 + step] = { v, v, v }
  end
end

local function to_cterm(hex)
  local r = tonumber(hex:sub(2, 3), 16)
  local g = tonumber(hex:sub(4, 5), 16)
  local b = tonumber(hex:sub(6, 7), 16)
  local best, best_dist = 0, math.huge
  for i = 0, 255 do
    local c = xterm[i]
    local d = 0.299 * (c[1] - r) ^ 2 + 0.587 * (c[2] - g) ^ 2 + 0.114 * (c[3] - b) ^ 2
    if d < best_dist then
      best, best_dist = i, d
    end
  end
  return best
end

-- 角色名 -> { gui 色值, cterm 色值 }；支持别名与省略 cterm
local function resolve(variant, role, depth)
  if role == nil then
    return nil, nil
  end
  local value = assert(variant.colors[role], 'alice palette: 缺少角色 ' .. role)
  if type(value) == 'string' then
    assert((depth or 0) < 8, 'alice palette: 角色别名出现循环 ' .. role)
    return resolve(variant, value, (depth or 0) + 1)
  end
  local hex = value[1]
  return hex, value[2] or to_cterm(hex)
end

local function link_all(links)
  for _, l in ipairs(links) do
    vim.api.nvim_set_hl(0, l[1], { link = l[2] })
  end
end

-- nvim 在 :colorscheme 之后会重置 @ 组，所以首次加载用 defer_fn、切换时用 autocmd 兜住
local function apply_ts(name)
  local group = vim.api.nvim_create_augroup('alice_' .. name .. '_ts', { clear = true })
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = group,
    pattern = name,
    callback = function()
      link_all(spec.ts_links)
    end,
  })
  vim.defer_fn(function()
    link_all(spec.ts_links)
  end, 0)
end

function M.load(variant_name)
  local key = tostring(variant_name):gsub('^alice%-', '')
  local variant = assert(palette[key],
    'alice: 未知主题 ' .. tostring(variant_name) .. '（可用：' .. table.concat(M.names, ', ') .. '）')
  local name = 'alice-' .. key

  vim.cmd('hi clear')
  if vim.fn.exists('syntax_on') == 1 then
    vim.cmd('syntax reset')
  end
  vim.o.background = variant.background
  vim.o.termguicolors = true
  vim.g.colors_name = name

  for _, row in ipairs(spec.groups) do
    local group, fg_role, bg_role, attr = row[1], row[2], row[3], row[4]
    local fg, fg_cterm = resolve(variant, fg_role)
    local bg, bg_cterm = resolve(variant, bg_role)
    local opts = {}
    if fg then
      opts.fg, opts.ctermfg = fg, fg_cterm
    end
    if bg then
      opts.bg, opts.ctermbg = bg, bg_cterm
    end
    if attr then
      if attr == 'undercurl' then
        opts.undercurl, opts.cterm = true, { underline = true }
      elseif attr == 'strikethrough' then
        opts.strikethrough = true
      else
        opts[attr], opts.cterm = true, { [attr] = true }
      end
    end
    vim.api.nvim_set_hl(0, group, opts)
  end

  link_all(spec.links)
  apply_ts(name)

  for i, hex in ipairs(variant.terminal) do
    vim.g['terminal_color_' .. (i - 1)] = hex
  end
end

return M
