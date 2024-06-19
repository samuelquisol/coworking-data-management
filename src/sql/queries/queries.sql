-- Simple views
SELECT * FROM Users;
SELECT * FROM Rooms;
SELECT * FROM Sessions;
SELECT * FROM Workspaces;
SELECT * FROM Reservations;


-- View the list of available workspaces in a room for a specific session
SELECT *
FROM Workspaces
WHERE room_id = 'UUID-ROOM-ID'
AND workspace_id NOT IN (
    SELECT workspace_id
    FROM Reservations
    WHERE session_id = 'UUID-SESSION-ID'
    AND status = 'confirmed'
);

SELECT room_id, start_time, end_time FROM Sessions;

-- View the list of occupied workspaces in a room for a specific session
SELECT *
FROM Workspaces
WHERE room_id = 'UUID-ROOM-ID'
AND workspace_id IN (
    SELECT workspace_id
    FROM Reservations
    WHERE session_id = 'UUID-SESSION-ID'
    AND status = 'confirmed'
);

-- View sessions ordered by the most occupied
SELECT session_id, COUNT(*) as reservation_count
FROM Reservations
WHERE status = 'confirmed'
GROUP BY session_id
ORDER BY reservation_count DESC;

-- View sessions ordered by the most available
SELECT session_id, COUNT(*) as available_count
FROM Workspaces
WHERE workspace_id NOT IN (
    SELECT workspace_id
    FROM Reservations
    WHERE status = 'confirmed'
)
GROUP BY session_id
ORDER BY available_count DESC;

-- View the list of workspaces assigned to a user
SELECT workspace_id
FROM Reservations
WHERE user_id = 'UUID-USER-ID'
AND status = 'confirmed';

-- View the list of workspaces assigned to a session
SELECT workspace_id
FROM Reservations
WHERE session_id = 'UUID-SESSION-ID'
AND status = 'confirmed';
