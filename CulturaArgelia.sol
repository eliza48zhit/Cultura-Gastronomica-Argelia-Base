// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaArgelia
 * @dev Registro de tecnicas de granulometria y cromatismo de salsas.
 * Serie: Sabores de Africa (12/54)
 */
contract CulturaArgelia {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        uint256 nivelGranulometria; // 1: Muy fino (Seffa), 10: Grueso (Berkoukes)
        string colorSalsa;         // Roja, Blanca o Amarilla
        bool usaSmene;             // Mantequilla clarificada fermentada
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con el Couscous Royal Argelino
        registrarPlato(
            "Couscous Algerois", 
            "Semola fina, cordero, garbanzos, calabacin, nabo.",
            "Vaporizar la semola tres veces y servir con salsa blanca perfumada con canela.",
            2, 
            "Blanca", 
            true
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        uint256 _grano, 
        string memory _color,
        bool _smene
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_grano <= 10, "Escala granulometria: 1 a 10");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            nivelGranulometria: _grano,
            colorSalsa: _color,
            usaSmene: _smene,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        uint256 grano,
        string memory color,
        bool smene,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.nivelGranulometria, p.colorSalsa, p.usaSmene, p.likes);
    }
}
