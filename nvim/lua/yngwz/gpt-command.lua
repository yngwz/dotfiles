local gpt = {}

-- Get context (current line)
function gpt.get_current_line_context()
    return vim.api.nvim_get_current_line()
end

-- Handle output (replace current line)
function gpt.replace_current_line_output(result)
    vim.api.nvim_set_current_line(result)
end

local function call_openAI(prompt, options)
    -- Define the URL, headers, and body
    local url = "https://api.openai.com/v1/engines/davinci-codex/completions"
    local headers = {
        "Content-Type: application/json",
        "Authorization: Bearer YOUR_OPENAI_API_KEY",
    }
    local body = {
        prompt = 'Translate this English text to French: "Hello, world!"',
        max_tokens = 60,
    }
    body = vim.fn.json_encode(body)

    -- Define the command
    local cmd = "curl"
    local args = {
        "-X",
        "POST",
        "-H",
        headers[1],
        "-H",
        headers[2],
        "-d",
        body,
        url,
    }

    -- Define the callback function
    local function onread(err, data)
        if err then
            print("Error: ", err)
        else
            -- Parse the response
            local response = vim.fn.json_decode(data)
            print(response.choices[1].text.strip)
        end
    end

    -- Start the job
    vim.fn.jobstart(
        { cmd, args },
        { on_stdout = onread, stdout_buffered = true }
    )
end

-- Parse template
function gpt.parse_template(template, vars)
    local result = template
    for k, v in pairs(vars) do
        result = result:gsub("${" .. k .. "}", v)
    end
    return result
end

-- Main function
function gpt.run(params)
    -- Get context
    local context = params.context()

    -- Fill in template
    local vars = params.variables or {}
    vars.context = context
    local prompt = gpt.parse_template(params.template, vars)

    -- Get result from GPT model
    -- (For now, let's just return the prompt as the "result".)
    local result = prompt -- TODO: replace with actual GPT model

    -- Handle output
    params.output(result)
end
