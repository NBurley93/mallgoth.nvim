local M = {}

M.colors = require('mallgoth.palette')
M.utils = require('mallgoth.utils')
M.editor_groups = require('mallgoth.groups.editor')

function M.setup(user_conf)
    M.utils.process_groups(M.editor_groups.get(M.colors))

    -- Load all integrations
    local integration_modules = vim.api.nvim_get_runtime_file('mallgoth/groups/integrations/*.lua', true)
    for _, module_path in ipairs(integration_modules) do
        local ok, loaded = pcall(require, module_path)
        if not ok then
            vim.notify('Error loading Mallgoth integration: ' .. module_path .. '\n\n' .. loaded, vim.log.levels.ERROR)
        else
            if type(loaded) == 'table' then
                M.utils.process_groups(loaded)
            end
        end
    end
end

return M
