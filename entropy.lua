-- 熵值检测 Postdissector Lua 脚本
print("[Entropy Postdissector Plugin] Loaded successfully!")

-- 定义新字段
local entropy_field = ProtoField.float("entropy.value", "Packet Entropy")
local entropy_proto = Proto("entropy", "Packet Entropy")
entropy_proto.fields = { entropy_field }

local function calc_entropy(data)
    local freq = {}
    local len = #data
    if len == 0 then return 0 end
    for i=1,len do
        local b = data:byte(i)
        freq[b] = (freq[b] or 0) + 1
    end
    local entropy = 0
    for _,count in pairs(freq) do
        local p = count / len
        entropy = entropy - p * math.log(p) / math.log(2)
    end
    return entropy
end

function entropy_proto.dissector(tvb, pinfo, tree)
    local data = tvb:raw()
    if data and #data > 0 then
        local entropy = calc_entropy(data)
        -- 在详细解析树显示
        local subtree = tree:add(entropy_proto, "Packet Entropy Analysis")
        subtree:add(entropy_field, entropy)
        -- 在Info列追加
        pinfo.cols.info:append(string.format(" [Entropy=%.2f]", entropy))
    end
end

register_postdissector(entropy_proto)