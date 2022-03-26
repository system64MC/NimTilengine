import Types
import TilengineBinding

# type
#     INNER_C_STRUCT_Tilengine_132* {.bycopy.} = object
#         index*: uint16
#         flags*: uint16
  
#     uniontile {.bycopy, union.} = object
#         value*: uint32
#         anoTilengine132*: INNER_C_STRUCT_Tilengine_132

type
  INNER_C_STRUCT_Tilengine_132* {.bycopy.} = object
    index*: uint16            ## !< tile index
    flags*: uint16            ## !< attributes (FLAG_FLIPX, FLAG_FLIPY, FLAG_PRIORITY)

  TileObject* {.bycopy, union.} = object
    value*: uint32
    props*: INNER_C_STRUCT_Tilengine_132
 
# importc:
#     sysPath "/c/clang/1301/include"
#     path "./includes"
#     "Tilengine.h"

# TILEMAP
proc createTilemap*(rows: int, cols: int, tiles: TLN_Tile, bgcolor: uint, tileset: TLN_Tileset): TLN_Tilemap =
    return TLN_CreateTilemap(rows.cint, cols.cint, tiles, bgcolor.cuint, tileset)

proc createTilemap*(rows: int, cols: int, tiles: TLN_Tile, bgcolor: Color, tileset: TLN_Tileset): TLN_Tilemap =
    var color = (bgcolor.r shl 24) + (bgcolor.g shl 16) + (bgcolor.b shl 24) + (bgcolor.a)
    return TLN_CreateTilemap(rows.cint, cols.cint, tiles, color.cuint, tileset)

proc loadTilemap*(file: string, layerName: string = ""): TLN_Tilemap = 
    if(layerName == ""):
        return TLN_LoadTilemap(file.cstring, nil)
    else:
        return TLN_LoadTilemap(file.cstring, layerName.cstring)

proc cloneTilemap*(self: TLN_Tilemap): TLN_Tilemap =
    return TLN_CloneTilemap(self)

proc getTilemapRows*(self: TLN_Tilemap): int =
    return TLN_GetTilemapRows(self).int

proc getTilemapCols*(self: TLN_Tilemap): int =
    return TLN_GetTilemapCols(self)

proc getTilemapTileset*(self: TLN_Tilemap): TLN_Tileset =
    return TLN_GetTilemapTileset(self)

proc getTilemapTile*(tilemap: TLN_Tilemap, row: int, col: int, tile: TLN_Tile): bool =
    return TLN_GetTilemapTile(tilemap, row.cint, col.cint, tile)

proc setTilemapTile*(tilemap: TLN_Tilemap, row: int, col: int, tile: ptr TileObject): bool =
    return TLN_SetTilemapTile(tilemap, row.cint, col.cint, cast[TLN_Tile](tile))

proc copyTiles*(src: TLN_Tilemap, srcrow: int, srccol: int, rows: int, cols: int, dst: TLN_Tilemap, dstrow: int, dstcol: int): bool =
    return TLN_CopyTiles(src, srcrow.cint, srccol.cint, rows.cint, cols.cint, dst, dstrow.cint, dstcol.cint)

proc deleteTilemap*(self: TLN_Tilemap): bool =
    return TLN_DeleteTilemap(self)