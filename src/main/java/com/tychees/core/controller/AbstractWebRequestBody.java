package com.tychees.core.controller;

public abstract class AbstractWebRequestBody 
{
	// Caller application name (e.g. inventory, pos, etc.)
	public String appName;
	// Current session Id
    public String sessionId;
    // Current selected place Id
    public String placeId;
    // Last time when synced with remote (in milliseconds)
    public Long lastSyncedTime;
    // Full Bean
    public boolean fullBean = false;
    // View Bean
    public boolean viewBean = false;
    // Offline Database enabled at client?
    public boolean offlineDatabase = false;    
}