function Span(el)
  -- List of classes that should trigger the annotation effect
  local tags = {"entity", "indicator", "uncertainty", "priority", "spatiality"}
  
  for _, tag in ipairs(tags) do
    if el.classes:includes(tag) then
      -- 1. Add the base 'annotated' class for CSS styling
      el.classes:insert("annotated")
      -- 2. Set 'data-label' to the tag name (capitalized)
      el.attributes["data-label"] = tag:gsub("^%l", string.upper)
      return el
    end
  end
end