package com.furb.devmobile.Controller.Pessoa;

import com.furb.devmobile.DTO.Pessoa.PessoaDTO;
import com.furb.devmobile.Entity.Pessoa.PessoaEntity;
import com.furb.devmobile.Service.Pessoa.PessoaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/pessoa")
public class PessoaController {

    @Autowired
    private PessoaService pessoaService;

    @PostMapping("/new")
    public PessoaEntity newPerson(@RequestBody PessoaDTO newPerson) {
        return pessoaService.newPerson(newPerson);
    }

    @GetMapping("/all")
    public List<PessoaDTO> all() {
        return pessoaService.all();
    }
}
