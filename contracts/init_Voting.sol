//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;
import{ voteBase } from "./voteBase_ver1.sol";

contract init_Voting is voteBase{
    // Store accounts that have voted/revoted
    mapping(address => int) public voters;
    mapping(address => int) public revoters;
    mapping(address => int) public votefor;
    mapping(address => string) public voteciphertext;
    mapping(address => string) public revoteciphertext;
    string [] validballot ;


    uint public CurrentTime = block.timestamp;
    uint public candidatesCount;
    uint public number;
    uint public max;
    uint public maxnum;
    uint public totalnum;
    address public revaddress;
    address public senaddress;
    string _privatekey;

    constructor(string memory _publickey,string memory _eventName,string[] memory _candidateInfo,uint[] memory _init, string memory _info, string[] memory _resume)voteBase(_publickey, _eventName,_candidateInfo,_init,_info,_resume){
        candidatesCount = _candidateInfo.length;
        for(uint i = 1;i<=_candidateInfo.length;i++){
            candidatesList[i] = Candidate(i,_candidateInfo[i-1],0,_resume[i-1]);
            emit done(DoneFlag.setCandidates, "Set Candidates");
        }
    }
    function getPublickey() public view returns(string memory){
        return(publickey);
    }
    function getEventName() public view returns(string memory){
        return(eventName);
    }
    function getvote() public view returns(int){
        return voters[msg.sender];
    }
    function getrevote() public view returns(int){
        return revoters[msg.sender];
    }
    function getvotefor() public view returns(int){
        return votefor[msg.sender];
    }
    function getVoteCiphertext() public view returns(string memory){
        return voteciphertext[msg.sender];
    }

    function getsender() public view returns(address){
        return msg.sender;
    }

    function getRevoteCiphertext() public view returns(string memory){
        return revoteciphertext[msg.sender];
    }
    function getPrivatekey(string memory key) public{
         _privatekey=key;
          emit privateKey(DoneFlag.privatekey, "Set PrivatKey");
    }
    function getpkey() public view returns(string memory){
        return _privatekey;
    }
    function getvoteforname() public view returns(string memory){
        return candidatesList[uint(votefor[msg.sender])].name;
    }
    function gettimealready() public view returns(int){
        int timea=0;
        if(block.timestamp+28800<transtime(votingStartTime)){
            timea=1;
        }
        else{
            timea=0;
        }
        return timea;
    }
    function gettimeend() public view returns(int){
        int timeb=0;
        if(block.timestamp+28800>transtime(votingEndTime)){
            timeb=1;
        }
        else{
            timeb=0;
        }
        return timeb;
    }
    function regettimealready() public view returns(int){
        int timec=0;
        if(block.timestamp+28800<transtime(revotingStartTime)){
            timec=1;
        }
        else{
            timec=0;
        }
        return timec;
    }
    function regettimeend() public view returns(int){
        int timed=0;
        if(block.timestamp+28800>transtime(revotingEndTime)){
            timed=1;
        }
        else{
            timed=0;
        }
        return timed;
    }

    //function getsender() public view returns(address){
       // return senaddress;
    //}
     function getTotalVotes(uint _candidateId) view public returns(uint) {

        return candidatesList[_candidateId].voteCount;

    }
    function getstartTime() public view returns(uint,uint,uint,uint,uint,uint){
        return(votingStartTime.year,votingStartTime.month,votingStartTime.date,votingStartTime.hour,votingStartTime.min,votingStartTime.sec);
    }
    function getendTime() public view returns(uint,uint,uint,uint,uint,uint){
        return(votingEndTime.year,votingEndTime.month,votingEndTime.date,votingEndTime.hour,votingEndTime.min,votingEndTime.sec);
    }
    function getrestartTime() public view returns(uint,uint,uint,uint,uint,uint){
        return(revotingStartTime.year,revotingStartTime.month,revotingStartTime.date,revotingStartTime.hour,revotingStartTime.min,revotingStartTime.sec);
    }
    function getreendTime() public view returns(uint,uint,uint,uint,uint,uint){
        return(revotingEndTime.year,revotingEndTime.month,revotingEndTime.date,revotingEndTime.hour,revotingEndTime.min,revotingEndTime.sec);
    }
    function getCandidatesName() public view returns(string memory,string memory,string memory){
        return (candidatesList[1].name,candidatesList[2].name,candidatesList[3].name);
    }
    function getinfo() public view returns(string memory){
        return (info);
    }
    function getresume() public view returns(string memory,string memory,string memory){
        return (candidatesList[1].info,candidatesList[2].info,candidatesList[3].info);
    }
    function getnumber(uint num) public {
        number = num;
    }
    function tomax(uint m,uint mt) public {
        max = m;
        maxnum= mt;
    }
    function getresult() public view returns(string memory,uint){

        return (candidatesList[max].name,maxnum);
    }
    function getnum() public view returns(uint){
        return (number);
    }
    function getname() public view returns(string memory){
        return candidatesList[number].name;
    }
    function getname1(uint num) public view returns(string memory){
        return candidatesList[num].name;
    }
    function gettotalpeo() public view returns(uint){
        return validballot.length;
    }

    function callsha256(string memory c) public pure returns(string memory){
      return toHex(sha256(abi.encodePacked(c)));
   }

    function getvalid(uint i)public view returns(string memory){
            return validballot[i];
    }

function toHex16 (bytes16 data) internal pure returns (bytes32 result) {
    result = bytes32 (data) & 0xFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000 |
          (bytes32 (data) & 0x0000000000000000FFFFFFFFFFFFFFFF00000000000000000000000000000000) >> 64;
    result = result & 0xFFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000 |
          (result & 0x00000000FFFFFFFF000000000000000000000000FFFFFFFF0000000000000000) >> 32;
    result = result & 0xFFFF000000000000FFFF000000000000FFFF000000000000FFFF000000000000 |
          (result & 0x0000FFFF000000000000FFFF000000000000FFFF000000000000FFFF00000000) >> 16;
    result = result & 0xFF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000 |
          (result & 0x00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000) >> 8;
    result = (result & 0xF000F000F000F000F000F000F000F000F000F000F000F000F000F000F000F000) >> 4 |
          (result & 0x0F000F000F000F000F000F000F000F000F000F000F000F000F000F000F000F00) >> 8;
    result = bytes32 (0x3030303030303030303030303030303030303030303030303030303030303030 +
           uint256 (result) +
           (uint256 (result) + 0x0606060606060606060606060606060606060606060606060606060606060606 >> 4 &
           0x0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F) * 7);
}

function toHex (bytes32 data) public pure returns (string memory) {
    return string (abi.encodePacked ("0x", toHex16 (bytes16 (data)), toHex16 (bytes16 (data << 128))));
}
    function equal1() public view returns(bool){
        if (hashCompareInternal1(callsha256(revoteciphertext[msg.sender]), voteciphertext[msg.sender])==true){
            return true;
        }
        return false;
    }
function hashCompareInternal1(string memory a, string memory b) public pure returns (bool) {
        if (keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b))){
            return true;
        }
        else{
            return false;
        }
    }
    function transtime(time memory x)internal pure returns(uint){
        uint  Y = (x.year - 1) * 365 + x.year / 4 - x.year / 100 + x.year / 400;
        uint  M = 367 * (x.month-2) / 12 - 30 + 59;
        uint  D = x.date - 1;
        uint  X = Y + M + D - 719162;
        uint  T = ((X * 24 + x.hour) * 60 + x.min) * 60 + x.sec;
        return T;
    }
    function vote (string memory _ciphertext) public {
        // require that they haven't voted before
        require(voters[msg.sender]!=1, "has voted");

        require (CurrentTime+28800>transtime(votingStartTime), "not voting time yet");

        require (CurrentTime+28800<transtime(votingEndTime), "exceed voting time");

        // require a valid candidate
        //require(number > 0 && number <= candidatesCount, "candidate invalid");

        // record that voter has voted
        voters[msg.sender] = 1;
        totalnum++;
        senaddress= msg.sender;
        // update candidate vote Count
        //candidatesList[number].voteCount ++;
        //votefor[msg.sender]=int(number);
        voteciphertext[msg.sender]=_ciphertext;
        // trigger voted event 紀錄在交易裡
        // emit votedEvent(number);
        emit done(DoneFlag.hasVoted, "Voted");
    }

function revote (string memory _reciphertext) public {

        // require that they have voted before
        require(voters[msg.sender]==1, "has't voted");
         // require that they haven't revoted before
        require(revoters[msg.sender]!=1, "has revoted");
        require (CurrentTime+28800>transtime(revotingStartTime), "not revoting time yet");
        require (CurrentTime+28800<transtime(revotingEndTime),"exceed revoting time");

        // record that voter has revoted

        revoters[msg.sender] = 1;
        revaddress= msg.sender;
        revoteciphertext[msg.sender]=_reciphertext;
        if (hashCompareInternal1(callsha256(revoteciphertext[msg.sender]), voteciphertext[msg.sender])==true){
            validballot.push(revoteciphertext[msg.sender]);
            emit valid(DoneFlag.validBallot,"valid ballot");
        }
        emit done(DoneFlag.hasRevoted, "has revoted");
    }
}
