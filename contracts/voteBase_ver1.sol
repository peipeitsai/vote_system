//SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;
contract voteBase {

   //save CEC account
    address internal CEC;

    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
        string info;
    }
    struct time{
        uint year;
        uint month;
        uint date;
        uint hour;
        uint min;
        uint sec;
    }
    //save CEC account
    Candidate public FirstCandidates;
    time public votingStartTime;
    time public votingEndTime;
    time public revotingStartTime;
    time public revotingEndTime;
    string public eventName;
    string public publickey;
    string public info;
    constructor(string memory _publickey, string memory _eventName,string[] memory _candidateInfo,uint[] memory _init, string memory _info, string[] memory _resume){
        CEC = msg.sender;
        eventName = _eventName;
        publickey = _publickey;
        info=_info;
        FirstCandidates = Candidate({
            id:1,
            name:_candidateInfo[0],
            voteCount:0,
            info:_resume[0]
        });
        votingStartTime = time({
            year:_init[0],
            month:_init[1],
            date:_init[2],
            hour:_init[3],
            min:_init[4],
            sec:_init[5]
        });
        votingEndTime = time({
            year:_init[0],
            month:_init[6],
            date:_init[7],
            hour:_init[8],
            min:_init[9],
            sec:_init[10]
        });
        revotingStartTime = time({
            year:_init[0],
            month:_init[11],
            date:_init[12],
            hour:_init[13],
            min:_init[14],
            sec:_init[15]
        });
        revotingEndTime = time({
            year:_init[0],
            month:_init[16],
            date:_init[17],
            hour:_init[18],
            min:_init[19],
            sec:_init[20]
        });
    }


    mapping(uint => Candidate) public candidatesList;
   // uint public candidatesCount;
    modifier onlyCEC {
        require(msg.sender == CEC, "Permission denied. Please use CEC account.");
        _;
    }
    event valid(DoneFlag eventCode,string message);
    event privateKey(DoneFlag eventCode,string message);
    event done(DoneFlag eventCode, string message);
    event votedEvent (
        uint indexed _candidateId
    );
    enum DoneFlag {
        setCandidates, //設置候選人
        setVotingDate, //設置開始投票時間
        setRevotingDate, //設置開始復投時間
        hasVoted,//設置選民已投票
        hasRevoted,//設置選民已複投
        validBallot,//有效票
        privatekey//標註私鑰
    }
}
