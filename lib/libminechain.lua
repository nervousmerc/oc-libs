-- Based on https://medium.com/@lhartikk/a-blockchain-in-200-lines-of-code-963cc1cc0e54

local component = require('component')
local data = assert(require('data')) -- requires a 'data' loot disk
local datacard = assert(component.data) -- data card should be available

----------- Library  object ---------------

lib = {}

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

function getGenesisBlock()
  return Block.new(0,
                   "0",
                   0,
                   "dixitque Deus: fiat lux, et facta est lux.",
                   "361e406a85fcc54d358fa51b11d50e1517a5c2e97d2cd0b1163fd7e8a1f3367d")
end

----------- minechain object --------------

lib.minechain = {}
lib.minechain[1] = getGenesisBlock()

-------------------------------------------

function lib.getLatestBlock()
  return lib.minechain[#(lib.minechain)]
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

function lib.addBlock(blockData)
  nextBlock = lib.generateNextBlock(blockData)
  lib.minechain[#(lib.minechain) + 1] = nextBlock
  return nextBlock
end

function lib.dump()
  for k, v in ipairs(lib.minechain) do
    print('-------------')
    print(k, v)
  end
end

------------- end of module --------------
lib.Block = Block
return lib
