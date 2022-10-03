// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 <0.7.0;
pragma experimental ABIEncoderV2;

// @title Charitable Causes Project
// @author catellaTech

contract charitableCausesProject {
    /* We will do a small project to practice what we have learned so far, functions, modifiers, variables, mappings and more... */
    
    // Declarations required
    struct Cause{
        uint Id;
        string name;
        uint target_price;
        uint amount_raised;
    }
    
    uint counter_causes = 0;
    mapping (string => Cause) causes;
    
    //  This function allows you to register a new cause
    function newCause(string memory _name, uint _target_price) public payable{
        counter_causes = counter_causes++;
        causes[_name] = Cause(counter_causes, _name, _target_price, 0);
    }
    
    // This function returns true if we can donate to a cause and false otherwise.
    
    function ObjectiveAchieved(string memory _name, uint _donate) private view returns(bool){
        
        bool flag = false;
        Cause memory cause = causes[_name];
        
        if(cause.target_price >= (cause.amount_raised + _donate)){
            flag=true;
        }
        return flag;
        
    }
    
    
    // This function allows us to donate to a cause
    function donate(string memory _name, uint _amount) public returns(bool){
        
        bool accept_donation = true;
        
        if(ObjectiveAchieved(_name, _amount)){
            causes[_name].amount_raised = causes[_name].amount_raised + _amount;
        }else{
            accept_donation = false;
        }
        return accept_donation;
    }
    
    // This function tells us if we have reached the target price
    function check_cause(string memory _name) public view returns(bool, uint){
        
        bool limit_reached = false;
        Cause memory cause = causes[_name];
        
        if(cause.amount_raised >= cause.target_price){
            limit_reached = true;
        }
        
        return (limit_reached, cause.amount_raised);
        
    }
}
