// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Todo {
    struct Task {
        uint256 id;
        uint256 date;
        string content;
        string author;
        bool done;
        uint256 dateComplete;
    }

    mapping(uint256 => Task) public tasks;
    uint256 public nextTaskId;

    event TaskCreated(
        uint256 id,
        uint256 date,
        string content,
        string author,
        bool done
    );

    event TaskStatusToggled(uint256 id, bool done, uint256 date);

    function createTask(string memory _content, string memory _author)
        external
    {
        tasks[nextTaskId] = Task(
            nextTaskId,
            block.timestamp,
            _content,
            _author,
            false,
            0
        );
        emit TaskCreated(nextTaskId, block.timestamp, _content, _author, false);
        nextTaskId++;
    }

    function getTasks() external view returns (Task[] memory) {
        Task[] memory _tasks = new Task[](nextTaskId);
        for (uint256 i = 0; i < nextTaskId; i++) {
            _tasks[i] = tasks[i];
        }
        return _tasks;
    }

    function toggleDone(uint256 id) external {
        require(tasks[id].id != 0, "task does not exist");
        Task storage task = tasks[id];
        task.done = !task.done;
        task.dateComplete = task.done ? block.timestamp : 0;
        emit TaskStatusToggled(id, task.done, task.dateComplete);
    }
}
