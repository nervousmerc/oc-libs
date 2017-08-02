-- Based on https://medium.com/@lhartikk/a-blockchain-in-200-lines-of-code-963cc1cc0e54

local component = require('component')
local data = assert(require('data')) -- requires a 'data' loot disk
local datacard = assert(component.data) -- data card should be available

----------- Library  object ---------------

lib = {}

----------- minechain object --------------

lib.minechain = table.pack(lib.getGenesisBlock())

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
----------- end Block class -----------------------

function lib.getGenesisBlock()
  return Block.new(0,
                   "0",
                   0,
                   "dixitque Deus: fiat lux, et facta est lux.",
                   "361e406a85fcc54d358fa51b11d50e1517a5c2e97d2cd0b1163fd7e8a1f3367d")
end

function lib.calculateHash(index, previousHash, timestamp, data)
  local state = index..previousHash..timestamp..data
  return string.lower(data.toHex(datacard.sha256(state)))
end

function lib.generateNextBlock(blockData)
  local previousBlock = lib.getLatestBlock()
  local nextIndex = previousBlock.index + 1
  local nextTimestamp = math.floor(os.time())
  local nextHash = calculateHash(nextIndex, previousBlock.hash, nextTimestamp, blockData)
  return Block.new(nextIndex, previousBlock.hash, nextTimestamp, blockData, nextHash)
end

function lib.addBlock(block)

end

function lib.dump()
  for k, v in ipairs(minechain) do
    print('-------------')
    print(k, v)
  end
end

function lib.getLatestBlock()
  return minechain[minechain.n]
end


------------- end of module --------------
lib.Block = Block
return lib
