-- Enable the extension for UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Table Users
CREATE TABLE Users (
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    user_type VARCHAR(50) NOT NULL
);

-- Table Rooms
CREATE TABLE Rooms (
    room_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    room_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    capacity INTEGER NOT NULL
);

-- Table Workspaces
CREATE TABLE Workspaces (
    workspace_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    room_id UUID NOT NULL,
    workspace_row INTEGER NOT NULL,
    workspace_column INTEGER NOT NULL,
    type VARCHAR(50) NOT NULL,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- Table Sessions
CREATE TABLE Sessions (
    session_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    room_id UUID NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    description TEXT NOT NULL,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- Table Reservations
CREATE TABLE Reservations (
    reservation_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    workspace_id UUID NOT NULL,
    session_id UUID NOT NULL,
    reservation_time TIMESTAMP NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (workspace_id) REFERENCES Workspaces(workspace_id),
    FOREIGN KEY (session_id) REFERENCES Sessions(session_id)
);
