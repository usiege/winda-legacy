local addonName, addon, some = ...

print("--------")
print(...)
print("当前加载的插件是："..addonName)
for k,v in pairs(addon) do
    print(k, v)
end
print(some)
print("--------")

-- wow 里不可以用这个关键字
-- local testx = require(X)
print(X.showString)