const fs = require('fs');
require('request');

function sleep(ms) {
    return new Promise((resolve) => {
      setTimeout(resolve, ms);
    });
  }  


var exo_key = process.env.EXOSCALE_KEY
var exo_secret = process.env.EXOSCALE_SECRET
var exo_pool_id = process.env.EXOSCALE_INSTANCEPOOL_ID
var tar_port = process.env.TARGET_PORT

var cloudstack = new (require('./cloudstack'))({
	apiUri: 'https://api.exoscale.ch/compute',
	apiKey: exo_key,
	apiSecret: exo_secret
});

if(typeof exo_key === 'undefined')
{
    throw Error('exo_key not set');
}
if(typeof exo_secret === 'undefined')
{
    throw Error('exo_secret not set');
}
if(typeof exo_pool_id === 'undefined')
{
    throw Error('exo_pool_id not set');
}
if(typeof tar_port === 'undefined')
{
    throw Error('tar_port not set');
}


cloudstack.exec('listVirtualMachines', {}, async function(error, result) {
    while (true) {
        await sleep(5000);
        targeting(result);
    }

});

function targeting(result) {

    var targets = [];
    result.virtualmachine.forEach(vm => {
        if(vm.managerid == exo_pool_id){
            if(targets.indexOf(vm.nic[0].ipaddress)==-1) targets.push(vm.nic[0].ipaddress + ':' + tar_port);
        }
    });

    console.log(targets);
        
    const jObject = {
        "targets": targets,
        "labels": {}
    }
    
    data = JSON.stringify([jObject]);

    fs.writeFile('./srv/service-discovery/config.json', data, (err) => {
        console.log('wrote to file');
    });
    targets = [];
}

process.on('SIGINT', function () {
    process.exit(0);
});
process.on('SIGTERM', function () {
    process.exit(0);
});