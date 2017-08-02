lu = require('luaunit')
mc = require('libminechain')

TestLib = {}
function TestPrivate:testGenesisBlock()
  local gb = mc.minechain[1]
  lu.assertEquals(gb.index, 0)
  lu.assertEquals(gb.previousHash, "0")
  lu.assertEquals(gb.hash, "361e406a85fcc54d358fa51b11d50e1517a5c2e97d2cd0b1163fd7e8a1f3367d")
  lu.assertEquals(gb.timestamp, 0)
  lu.assertEquals(gb.data, "dixitque Deus: fiat lux, et facta est lux.")
end

function TestLib:testGetLatestBlock()
end

function TestLib:testCalculateHash()
end

function TestLib:testGenerateNextBlock()
end

function TestLib:testAddBlock()
end

function TestLib:testDumpBlock()
end

function TestLib:testDump()
end


TestBlock = {}
function TestBlock:testNew()
end

os.exit(luaunit.LuaUnit.run())
