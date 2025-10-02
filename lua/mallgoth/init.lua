local M = {}

M.colors = require('mallgoth.palette')
M.utils = require('mallgoth.utils')
M.editor_groups = require('mallgoth.groups.editor')

function M.setup(user_conf)
    M.utils.process_groups(M.editor_groups.get(M.colors))

    -- Load all integrations
    local integration_modules = require('mallgoth.groups.integrations')
    for _, mod in pairs(integration_modules) do
        if type(mod) == 'table' then
            M.utils.process_groups(mod)
        end
    end
end

return M
