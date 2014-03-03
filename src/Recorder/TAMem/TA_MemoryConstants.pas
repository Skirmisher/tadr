unit TA_MemoryConstants;

interface

const
  MAXPLAYERCOUNT = 10;

  TAdynmemStructPtr = $511DE8;
  TAMovementClassArray = $512358;

  TAdynmemStruct_SharedBits = $2a42; //asm
  TAdynmemStruct_LOS_Sight = $2a43; // Byte;  //asm
  TAdynmemStruct_LOS_Type = $14281; //asm
  TAdynmemStruct_Players = $1b63;  // 10 * PlayerStructSize   asm
  TAdynmemStruct_GameSpeed = $38A4B; // Word   asm

  TAdynmemStruct_Units = $14357; // Pointer      asm
  TAdynmemStruct_Units_EndMarker = $1435B; // Pointer  asm

  PlayerStructSize = $14b; //asm
  PlayerStruct_PlayerType = $73; //asm
  PlayerStruct_PlayerInfo = $27; //asm
  PlayerStruct_Index = $146;  //asm
  PlayerStruct_AlliedPlayers = $108; //asm
  PlayerStruct_Units = $67;  //asm
  PlayerStruct_Units_End = $6b;  //asm
  PlayerInfoStruct_IsWatching = $9B; //asm
  UnitStruct_OwnerPtr = $96; //asm
  UnitStructSize = $118; //asm

implementation

end.
