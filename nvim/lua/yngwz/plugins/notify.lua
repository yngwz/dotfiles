local present, notify = pcall(require, "notify")
if not present then
    print("notify is absent")
    return
end

notify.setup()

vim.notify = notify

-- Set notify as the default vim notification function
