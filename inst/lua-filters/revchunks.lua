-- A Pandoc filter for reversing knitted documents.  Text generated from
-- code in R Markdown has custom styles with names of the chunks that generated
-- them.  The filter replaces Divs and Spans with these custom styles with
-- placeholders like <<<redoc-inline-1>>, to be replaced with chunk content
-- later

local redoc_insertions = {}

function Div(elem)
  -- Create a table to store the names of all the redoc insertions found
  if (elem.classes[1] == "paragraph-insertion" or elem.classes[1] == "insertion") and string.find(elem.attributes["author"], "redoc_") then
    local _, _, id = string.find(elem.attributes["author"], "^redoc_([^_]+)_[^_]+_[^_]+$")
    if not redoc_insertions[id] then
      redoc_insertions[id] = true
      return pandoc.Para(pandoc.RawInline(FORMAT, "<<<" .. id ..">>>"))
    else
      return {}
    end
  else
    return nil
  end
end

function Span(elem)
  if elem.classes[1] and elem.classes[1] == "anchor" then
    return {}
  elseif (elem.classes[1] == "paragraph-insertion" or elem.classes[1] == "insertion") and string.find(elem.attributes["author"], "redoc_") then
    local _, _, id = string.find(elem.attributes["author"], "^redoc_([^_]+)_[^_]+_[^_]+$")
    if not redoc_insertions[id] then
      redoc_insertions[id] = true
    return pandoc.RawInline(FORMAT, "<<<" .. id .. ">>>")
    else
      return {}
    end
  else
    return nil
  end
end
