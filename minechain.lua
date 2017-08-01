----------- MineChain object

minechain = {}

----------- Block class -------------------
local Block = {}

local blockMT = {__index = Block}

function Block.new(index, previousHash, timestamp, data, hash)
  local o = {}
  setmetatable(o, blockMT)
  o.index = index
  o.previousHash = previousHash
  o.timestamp = timestamp
  o.data = data
  o.hash = hash
  return o
end 

function Block:calculateHash()
  local hash = string.format("hash: %d %s %d %s",
                              self.index, 
                              self.previousHash, 
                              self.timestamp, 
                              self.data)
  return hash
end

minechain.Block = Block
return minechain