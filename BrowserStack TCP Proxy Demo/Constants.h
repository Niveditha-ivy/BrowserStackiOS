/******************************************************************************/
/**
 ** \file Constants.h
 **
 **  This file contains all the base classes for client server messaging framework.
 **
 ** Copyright (c) PartyGaming, Plc. All rights reserved.
 ** 
 *******************************************************************************/
 
//TODO: Suyash cleanup unnecessary entity types.
#define ENTITY_TYPE_INT  0x01
#define ENTITY_TYPE_LONG  0x02
#define ENTITY_TYPE_STRING  0x03
#define ENTITY_TYPE_BOOLEAN  0x04 
#define ENTITY_TYPE_SHORT 0x05
#define ENTITY_TYPE_STRINGEX 0x09
#define ENTITY_TYPE_VECTOR  0xF0
#define ENTITY_TYPE_HASHTABLE  0xF1
#define ENTITY_TYPE_OBJECT  0xFF
#define ENTITY_TYPE_NULL  0xFE
#define ENTITY_TYPE_BYTE  0xFD
#define ENTITY_TYPE_BYTE_ARRAY 0xFC
#define ENTITY_TYPE_GENERIC_ARRAY 0xF4

#define NATURE_HOMOGENEOUS 0x07 
#define NATURE_HETROGENEOUS 0x08

#define ENABLE_SRLZR_BW_COMPATIBILTY TRUE