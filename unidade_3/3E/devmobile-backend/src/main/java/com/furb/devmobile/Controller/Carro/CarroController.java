package com.furb.devmobile.Controller.Carro;

import com.furb.devmobile.DTO.Carro.CarroDTO;
import com.furb.devmobile.Entity.Carro.CarroEntity;
import com.furb.devmobile.Service.Carro.CarroService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(maxAge = 3600)
@RestController
@RequestMapping("/carro")
public class CarroController {

    @Autowired
    private CarroService carroService;

    @PostMapping("/new")
    public CarroEntity newCar(@RequestBody CarroDTO newCar) {
        return carroService.newCar(newCar);
    }

    @GetMapping("/all")
    public List<CarroDTO> all() {
        return carroService.all();
    }
}
