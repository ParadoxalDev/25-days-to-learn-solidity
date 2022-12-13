import keccak from "keccak";

const {MerkleTree} = require('merkletreejs');
const keccak256 = require('keccak256');
const whitelist =  require('../assets/whitelist.json');

function GenerateMerkle() {
    let w1Tab = [];

    whitelist.map(a => {
        w1Tab.push(a.address);
    })

    const leaves = w1Tab.map(a => keccak256(a));

    const tree = new MerkleTree(leaves, keccak256, { sort: true});

    const root = tree.getHexRoot();
    console.log("whitelist root : ", root);

    const addressToCheck = "0xBcD09dfEc85285eE39D7CbF195fc973CdE2213c2";

    const proof = tree.getHexProof(keccak256(addressToCheck));

    console.log('Merkle proof for' , addressToCheck, ':', proof);
}

GenerateMerkle().then();