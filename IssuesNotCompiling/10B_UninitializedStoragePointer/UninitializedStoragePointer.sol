// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The Car variable that is declared in the "RegisterCar" method is not initialized before being writte.
contract UninitializedReference{

    struct Car{
        string Make;
        string Model;
        uint Mileage;
        uint CarId;
        address Owner;
    }

    mapping(uint=>Car) private _cars;

    function RegisterCar(uint carId,uint mileage,string calldata make, string calldata model ) external
    {
        require(mileage>0,"A car cannot have 0 kilometers");
        Car storage car;
        car.CarId=carId;
        car.Mileage=mileage;
        car.Make=make;
        car.Model=model;
        car.Owner=msg.sender;
        _cars[carId]=car;
    }

    function getKilometers(uint carId) external view returns(uint){
        require(_cars[carId].Mileage>0,"A car with the provided carId is not registered");
        return _cars[carId].Mileage;
    }

    function getCar(uint carId) external view returns(Car memory){
        require(_cars[carId].Mileage>0,"A car with the provided carId is not registered");
        return _cars[carId];
    }

    function adjustKilometers(uint carId,uint newMileage) external
    {
        require(_cars[carId].Mileage>newMileage,"A car with the provided carId is not registered or the new mileage is lower than the old one");
        require(_cars[carId].Owner==msg.sender,"You do not own this car");
        _cars[carId].Mileage=newMileage;
    }
}