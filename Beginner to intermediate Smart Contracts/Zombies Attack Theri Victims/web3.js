//Deploying SmartContract
var Tx = require('ethereumjs-tx').Transaction 
const Web3 = require('web3')
const web3 = new Web3('https://ropsten.infura.io/v3/{KEY}')

const accout = '0x8Db58778A45c390Df553e91aDe76c6F893Cc17f4'

//Check connection with ropsten network 
web3.eth.getBalance(accout,(err,result)=>{
  console.log(result)
})
const privateKey = Buffer.from(process.env.PRIVATE_KEY.substr(2),'hex')
console.log(privateKey)


//Deploy Smart Contract 
web3.eth.getTransactionCount(accout,(err,txCount) => {
  //Smart Contract Data 
  const data = ''

  const txObject = {
    nonce:web3.utils.toHex(txCount),
    gasLimit:web3.utils.toHex(1000000),
    gasPrice: web3.utils.toHex(web3.utils.toWei('10','gwei')),
    data:data
  }  
  //Sign the transaction 
  const tx = new Tx(txObject,{chain:'ropsten',hardfork:'petersburg'})
  tx.sign(privateKey)

  const serializedTx = tx.serialize()
  const raw = '0x' + serializedTx.toString('hex')

  //Broadcast the transaction
  web3.eth.sendSignedTransaction(raw,(err,txHash) =>{
    console.log('err',err,'txHash',txHash)
  })
})


//Así es como accederiamos a nuestro contrato:
var contractABI = [{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"zombieId","type":"uint256"},{"indexed":false,"internalType":"string","name":"name","type":"string"},{"indexed":false,"internalType":"uint256","name":"dna","type":"uint256"}],"name":"NewZombie","type":"event"},{"inputs":[{"internalType":"string","name":"_name","type":"string"}],"name":"createRandomZombie","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"zombies","outputs":[{"internalType":"string","name":"name","type":"string"},{"internalType":"uint256","name":"dna","type":"uint256"}],"stateMutability":"view","type":"function"}]
var contractAddress = ''

var ZombieFactory = new web3.eth.Contract(contractABI,contractAddress)

// Asumiendo que tenemos la ID de nuestro zombi y la ID del gato que queremos atacar
let zombieId = 1;
let kittyId = 1;

// Para conseguir la imagen del CryptoKitty, necesitamos hacer una consulta a su API.
// Esta información no está guardada en la blockchain, solo en su servidor web.
// Si todo se guardase en la blockchain, no nos tendríamos que preocupar
// si el servidor se cae (apaga), si cambian la API, o si la compañía 
// nos bloquea la carga de imágenes si no les gusta nuestro juego de zombis ;)
let apiUrl = "https://api.cryptokitties.co/kitties/" + kittyId
$.get(apiUrl, function(data) {
  let imgUrl = data.image_url
  // haz algo para enseñar la imagen
})

// When the user clicks on a kitty:
$(".kittyImage").click(function(e) {
  // Llama al método `feedOnKitty` de tu contrato
  ZombieFeeding.feedOnKitty(zombieId, kittyId)
})

// Escuchamos el evento del NewZombie de nuestro contrato para que podamos mostrarlo:
ZombieFactory.NewZombie(function(error, result) {
  if (error) return
  // Esta función mostrará el zombi, como en la lección 1:
  generateZombie(result.zombieId, result.name, result.dna)
})