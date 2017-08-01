local component = require('component')
local data = assert(require('data')) -- requires a 'data' loot disk
local datacard = assert(component.data) -- data card should be available

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

function Block.getGenesisBlock()
  return Block.new(0,
                   "0",
                   0,
                   "dixitque Deus: fiat lux, et facta est lux.",
                   "361e406a85fcc54d358fa51b11d50e1517a5c2e97d2cd0b1163fd7e8a1f3367d")
end

function Block:calculateHash()
  local state = self.index..self.previousHash..self.timestamp..self.data
  return string.lower(data.toHex(datacard.sha256(state)))
end

minechain.Block = Block
return minechain
