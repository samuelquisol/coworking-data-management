-- Reserve a workspace for a specific session
INSERT INTO Reservations (user_id, workspace_id, session_id, reservation_time, status)
VALUES (
    'UUID-USER-ID',
    'UUID-WORKSPACE-ID',
    'UUID-SESSION-ID',
    NOW(),
    'confirmed'
);

-- Cancel a reservation
UPDATE Reservations
SET status = 'cancelled'
WHERE reservation_id = 'UUID-RESERVATION-ID';
