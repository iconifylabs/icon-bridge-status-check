// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.0 <0.8.5;
pragma abicoder v2;

import "../libraries/Types.sol";

interface IBMCManagement {
    /**
       @notice Update BMC periphery.
       @dev Caller must be an Onwer of BTP network
       @param _addr    Address of a new periphery.
     */
    function setBMCPeriphery(address _addr) external;

    /**
       @notice Adding another Onwer.
       @dev Caller must be an Onwer of BTP network
       @param _owner    Address of a new Onwer.
     */
    function addOwner(address _owner) external;

    /**
       @notice Removing an existing Owner.
       @dev Caller must be an Owner of BTP network
       @dev If only one Owner left, unable to remove the last Owner
       @param _owner    Address of an Owner to be removed.
     */
    function removeOwner(address _owner) external;

    /**
       @notice Checking whether one specific address has Owner role.
       @dev Caller can be ANY
       @param _owner    Address needs to verify.
     */
    function isOwner(address _owner) external view returns (bool);

    /**
       @notice Add the smart contract for the service.
       @dev Caller must be an operator of BTP network.
       @param _svc     Name of the service
       @param _addr    Service's contract address
     */
    function addService(string memory _svc, address _addr) external;

    /**
       @notice De-registers the smart contract for the service.  
       @dev Caller must be an operator of BTP network.
       @param _svc     Name of the service
     */
    function removeService(string calldata _svc) external;

    /**
       @notice Initializes status information for the link.
       @dev Caller must be an operator of BTP network.
       @param _link    BTP Address of connected BMC
     */
    function addLink(string calldata _link) external;

    /**
       @notice Set the link and status information. 
       @dev Caller must be an operator of BTP network.
       @param _link    BTP Address of connected BMC
       @param _blockInterval    Block interval of a connected link 
       @param _maxAggregation   Set max aggreation of a connected link
       @param _delayLimit       Set delay limit of a connected link
     */
    function setLink(
        string calldata _link,
        uint256 _blockInterval,
        uint256 _maxAggregation,
        uint256 _delayLimit
    ) external;

    function setLinkRxHeight(string calldata _link, uint256 _height) external;

    /**
       @notice Removes the link and status information. 
       @dev Caller must be an operator of BTP network.
       @param _link    BTP Address of connected BMC
     */
    function removeLink(string calldata _link) external;

    /**
       @notice Add route to the BMC.
       @dev Caller must be an operator of BTP network.
       @param _dst     BTP Address of the destination BMC
       @param _link    BTP Address of the next BMC for the destination
     */
    function addRoute(string calldata _dst, string calldata _link) external;

    /**
       @notice Remove route to the BMC.
       @dev Caller must be an operator of BTP network.
       @param _dst     BTP Address of the destination BMC
     */
    function removeRoute(string calldata _dst) external;

    /**
       @notice Registers relay for the network.
       @dev Caller must be an operator of BTP network.
       @param _link     BTP Address of connected BMC
       @param _addrs     A list of Relays
     */
    function addRelay(string calldata _link, address[] memory _addrs) external;

    /**
       @notice Unregisters Relay for the network.
       @dev Caller must be an operator of BTP network.
       @param _link     BTP Address of connected BMC
       @param _addrs     A list of Relays
     */
    function removeRelay(string calldata _link, address _addrs) external;

    /**
       @notice Get registered services.
       @return _servicers   An array of Service.
     */
    function getServices()
        external
        view
        returns (Types.Service[] memory _servicers);

    /**
       @notice Get registered links.
       @return _links   An array of links ( BTP Addresses of the BMCs ).
     */
    function getLinks() external view returns (string[] memory _links);

    /**
       @notice Get routing information.
       @return _routes An array of Route.
     */
    function getRoutes() external view returns (Types.Route[] memory _routes);

    /**
       @notice Get registered relays.
       @param _link        BTP Address of the connected BMC.
       @return _relayes A list of relays.
     */
    function getRelays(string calldata _link)
        external
        view
        returns (address[] memory _relayes);

    /**
        @notice Get BSH services by name. Only called by BMC periphery.
        @param _serviceName BSH service name
        @return BSH service address
     */
    function getBshServiceByName(string memory _serviceName)
        external
        view
        returns (address);

    /**
        @notice Get link info. Only called by BMC periphery.
        @param _to link's BTP address
        @return Link info
     */
    function getLink(string memory _to)
        external
        view
        returns (Types.Link memory);

    /**
        @notice Get rotation sequence by link. Only called by BMC periphery.
        @param _prev BTP Address of the previous BMC
        @return Rotation sequence
     */
    function getLinkRxSeq(string calldata _prev)
        external
        view
        returns (uint256);

    /**
        @notice Get transaction sequence by link. Only called by BMC periphery.
        @param _prev BTP Address of the previous BMC
        @return Transaction sequence
     */
    function getLinkTxSeq(string calldata _prev)
        external
        view
        returns (uint256);

    /**
        @notice Get link rxHeight of last received btp message's height. Only called by BMC periphery.
        @param _prev BTP Address of the previous BMC
        @return Rotation sequence
     */
    function getLinkRxHeight(string calldata _prev)
        external
        view
        returns (uint256);

    /**
        @notice Get relays by link. Only called by BMC periphery.
        @param _prev BTP Address of the previous BMC
        @return List of relays' addresses
     */
    function getLinkRelays(string calldata _prev)
        external
        view
        returns (address[] memory);

    /**
        @notice Get relays status by link. Only called by BMC periphery.
        @param _prev BTP Address of the previous BMC
        @return Relay status of all relays
     */
    function getRelayStatusByLink(string memory _prev)
        external
        view
        returns (Types.RelayStats[] memory);

    /**
        @notice Update rotation sequence by link. Only called by BMC periphery.
        @param _prev BTP Address of the previous BMC
        @param _val increment value
     */
    function updateLinkRxSeq(string calldata _prev, uint256 _val) external;

    /**
        @notice Increase transaction sequence by 1.
        @param _prev BTP Address of the previous BMC
     */
    function updateLinkTxSeq(string memory _prev) external;

    /**
        @notice Update link rxHeight of last received btp message's height. Only called by BMC periphery.
        @param _prev BTP Address of the previous BMC
        @param _val increment value
     */
    function updateLinkRxHeight(string calldata _prev, uint256 _val) external;

    /**
        @notice Add a reachable BTP address to link. Only called by BMC periphery.
        @param _prev BTP Address of the previous BMC
        @param _to BTP Address of the reachable
     */
    function updateLinkReachable(string memory _prev, string[] memory _to)
        external;

    /**
        @notice Remove a reachable BTP address. Only called by BMC periphery.
        @param _index reachable index to remove
     */
    function deleteLinkReachable(string memory _prev, uint256 _index) external;

    /**
        @notice Update relay status. Only called by BMC periphery.
        @param _relay relay address
        @param _blockCountVal increment value for block counter
        @param _msgCountVal increment value for message counter
     */
    function updateRelayStats(
        address _relay,
        uint256 _blockCountVal,
        uint256 _msgCountVal
    ) external;

    /**
        @notice resolve next BMC. Only called by BMC periphery.
        @param _dstNet net of BTP network address
        @return BTP address of next BMC and destinated BMC
     */
    function resolveRoute(string memory _dstNet)
        external
        view
        returns (string memory, string memory);

    /**
        @notice rotate relay for relay address. Only called by BMC periphery.
        @param _link BTP network address of connected BMC
        @param _currentHeight current block height of MTA from BMV
        @param _relayMsgHeight  block height of last relayed BTP Message
        @param _hasMsg check if message exists
        @return relay address
     */
    function rotateRelay(
        string memory _link,
        uint256 _currentHeight,
        uint256 _relayMsgHeight,
        bool _hasMsg
    ) external returns (address);
}
