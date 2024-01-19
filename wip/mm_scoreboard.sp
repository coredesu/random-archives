#pragma semicolon 1
#pragma newdecls required
#define PLUGIN_VERSION "1.4"
#include <sdktools>
#include <sourcemod>

 /* This plugin should be changed the value to bring up Looking for Player... on scoreboard 
but that never happens, i was able to crash the server once and idk how to replicate it.

server crash = good path in figuring it out... i guess
*/

int MMConnState[MAXPLAYERS+1];

public Plugin myinfo =
{
	name = "Match Scoreboard",
	author = "qtland",
	version = PLUGIN_VERSION,
}

enum MM_PlayerConnectionState_t
{
	MM_DISCONNECTED = 0,
	MM_CONNECTED,
	MM_CONNECTING,
	MM_LOADING,
	MM_WAITING_FOR_PLAYER
};

/* m_iConnectionState - Data Array. This is what i know */
/* playerIndex, MMConState? */

public void OnPluginStart()
{
	GameRules_SetProp("m_bPrintedUnbalanceWarning", true); // exception thrown since this is a private game rule and cannot be modified :(
	int entity = GetPlayerResourceEntity();
	if (entity != -1)
	{
	int offset = FindSendPropInfo("CTFPlayerResource", "m_iConnectionState");
	int bClient[MAXPLAYERS+1];
	GetEntDataArray(entity, offset, bClient, MaxClients+1);
		
	for (int i = 1; i <= MaxClients; i++)
	{
		bClient[i] = MM_WAITING_FOR_PLAYER;
		SetEntProp(entity, Prop_Send, "m_iConnectionState", bClient[i], _, i);
		PrintToServer("ConState : %i", bClient[i]);
		int mmConState = GetEntProp(entity, Prop_Send, "m_iConnectionState", _, i);
		PrintToServer("mmConState  : %i", mmConState );
	}
	
	SetEntDataArray(entity, offset, bClient, MaxClients+1);
	}
}
