-- ~/.config/nvim/lua/quotes.lua
local M = {}

-- Quote collection
M.quotes = {
    {
        "The only way to do great work is to love what you do.",
        "- Steve Jobs"
    },
    {
        "Code is like humor. When you have to explain it, it's bad.",
        "- Cory House"
    },
    {
        "Any fool can write code that a computer can understand.",
        "Good programmers write code that humans can understand.",
        "- Martin Fowler"
    },
    {
        "Premature optimization is the root of all evil.",
        "- Donald Knuth"
    },
    {
        "It don't care how strong you are. I don't care how fast you are. I can see the future, you don't live to see tomorrow.",
        "- Mark Grayson"
    },
    {
        "Sometimes you need to run before you can walk.",
        "- Tony Stark"
    },
    {
        "I shouldn't be alive... Unless it was for a reason.",
        "- Tony Stark"
    },
    {
        "Life, existence could be beautiful or it could be ugly, but that's on you.",
        "- Leon"
    },
    {
        "So, I'll ask you again: are you a one or a zero?",
        "- Mr. Robot"
    },
    {
        "When the past is always with you, it may as well be present; and if it is present, it will be future as well.",
        "- William Gibson"
    },
    {
        "Why a ball cap? Ninety percent of being cool is looking cool. And you look so much cooler wearing a ball cap.",
        "- Chris Kyle"
    },
    {
        "You have to slow your heart rate, stay calm. You have to shoot in between your heartbeats.",
        "- Chris Kyle"
    },
    {
        "I don't mean to shatter your ego, but this ain't the first time I've had a gun pointed at me.",
        "- Jules"
    },
    {
        "I have found, through painful experience, that the most import step a person can take is always the next one.",
        "- Brandon Sanderson"
    },
    {
        "I believe that every human has a finite number of heartbeats. I don't intend to waste any of mine.",
        "- Neil Armstrong"
    },
    {
        "This is how civilizations decline. They quit taking risks. And when they quit taking risks, arteries harden. Every year there are more referees and fewer doers. When you’ve had success for too long, you lose the desire to take risks.",
        "- Elon Musk"
    },
}

-- Function to wrap text within a width limit
local function wrap_text(text, width)
    local words = {}
    for word in text:gmatch("%S+") do
        table.insert(words, word)
    end

    local lines = {}
    local current_line = ""

    for _, word in ipairs(words) do
        if #current_line == 0 then
            current_line = word
        elseif #current_line + #word + 1 <= width then
            current_line = current_line .. " " .. word
        else
            table.insert(lines, current_line)
            current_line = word
        end
    end

    if #current_line > 0 then
        table.insert(lines, current_line)
    end

    return lines
end

-- Quote management functions
M.get_random_quote = function()
    local quotes = M.quotes
    math.randomseed(os.time())
    local random_idx = math.random(1, #quotes)
    return quotes[random_idx]
end

-- Quote formatting functions
M.format_quote_within_bounds = function(quote_lines, max_width)
    local formatted = {}
    local wrapped_lines = {}

    -- Wrap each line of the quote
    for _, line in ipairs(quote_lines) do
        local wrapped = wrap_text(line, max_width)
        for _, wrapped_line in ipairs(wrapped) do
            table.insert(wrapped_lines, wrapped_line)
        end
    end

    -- Add empty line after header art
    table.insert(formatted, "")

    -- Format each wrapped line
    for _, line in ipairs(wrapped_lines) do
        -- Center align the text
        local padding = max_width - #line
        local spaces_before = math.floor(padding / 2)

        -- Create centered line
        local formatted_line = string.rep(" ", spaces_before) .. line

        -- Add extra spacing if needed
        if #formatted_line < max_width then
            formatted_line = formatted_line .. string.rep(" ", max_width - #formatted_line)
        end

        table.insert(formatted, formatted_line)
    end

    -- Add empty line after quote
    table.insert(formatted, "")

    return formatted
end

return M
