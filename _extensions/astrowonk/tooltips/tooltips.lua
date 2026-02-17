local function ensure_html_deps()
  quarto.doc.add_html_dependency({
    name = 'load_tooltips',
    version = '1.0.0',
    scripts = { { path = "load_tooltips.js", afterBody = true } }
  })
end

-- 1. The original "tooltips" function (keep as is)
local function tooltips(args, kwargs, meta)
    if not quarto.doc.has_bootstrap() then
      return pandoc.Null()
    end
    ensure_html_deps()

    local tooltip = pandoc.utils.stringify(kwargs["tooltip"])
    local linktext = pandoc.utils.stringify(kwargs["text"])
    local icon = pandoc.utils.stringify(kwargs["icon"])
    local thetext = ""
    
    if linktext ~= '' then
      thetext = linktext
    elseif icon ~= '' then
      thetext = '<i class="bi bi-' .. icon .. '"></i>'
    else
      thetext = '<i class="bi bi-info-circle"></i>'
    end
    
    local a_block =
        ' <a href="javascript:void(0);" data-bs-toggle="tooltip" data-bs-title="' ..
        tooltip .. '">' .. thetext .. '</a>'

    return pandoc.RawInline('html', a_block)
end

-- 2. Your new "g" (gloss) shorthand function
local function g(args, kwargs, meta)
    if not quarto.doc.has_bootstrap() then
      return pandoc.Null()
    end
    ensure_html_deps()

    -- args[1] is the first word, args[2] is the second
    local word = pandoc.utils.stringify(args[1])
    local trans = pandoc.utils.stringify(args[2])

    local a_block =
        '<a href="javascript:void(0);" class="gloss-link" data-bs-toggle="tooltip" data-bs-title="' ..
        trans .. '">' .. word .. '</a>'

    return pandoc.RawInline('html', a_block)
end

-- 3. THE RETURN BLOCK (This must be at the very bottom)
return {
  ['tooltips'] = tooltips,
  ['g'] = g
}