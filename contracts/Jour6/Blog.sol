// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Blog {

    // @dev : Une structure contenant les infos de l'article avec comme noms (id, titre, texte, auteur et timestamp);

    struct Article {
        uint id;
        string titre;
        string texte;
        address auteur;
        uint timestamp;
    }

    // @dev : Un mapping contenant les articles par id avec comme nom (articles)

    mapping(uint => Article) public articles;

    // @dev : Une variable (id) qui peut être récupérée
    uint public id = 0;

    // @dev : Une variable (auteur) qui peut être récupérée
    address public auteur;

    // @dev : Un événement (NouvelArticle) avec toutes les informations de l'article
    event NouvelArticle(uint id, string titre, string texte, address auteur, uint timestamp);

    // @dev : Le créateur du contrat doit devenir auteur à la création
    constructor() {
        auteur = msg.sender;
    }

    // @dev : Une fonction (modifierAuteur) qui permet de modifier l'auteur du blog, seulement par l'auteur actuel
    function modifierAuteur(address _auteur) public {
        require(msg.sender == auteur, "Vous n'etes pas l'auteur");
        auteur = _auteur;
    }

    // @dev : Une fonction (creerArticle) qui permet d'ajouter un article, seulement par l'auteur actuel
    // elle doit émettre un événement NouvelArticle avec toutes les informations de l'article

    function creerArticle(string memory _titre, string memory _texte) public {
        id++;
        require(msg.sender == auteur, "Vous n'etes pas l'auteur!");
        articles[id] = Article(id,_titre, _texte, msg.sender, block.timestamp);
        emit NouvelArticle(id, _titre, _texte, msg.sender, block.timestamp);
    }
}
