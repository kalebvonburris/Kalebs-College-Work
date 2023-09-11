#[derive(Debug, Clone)]
pub struct Player {
    name: String,
    username: String,
    games_played: u64,
}

impl Player {
    /// Three parameter constructor.
    fn new(name: String, username: String, games_played: u64) -> Self {
        Self {
            name,
            username,
            games_played,
        }
    }

    // Setters
    fn set_name(&mut self, name: String) {
        self.name = name;
    }

    fn set_username(&mut self, username: String) {
        self.username = username;
    }

    fn set_games_played(&mut self, games_played: u64) {
        self.games_played = games_played;
    }

    /// Returns true if the player has played more
    /// than one game.
    fn is_active(&self) -> bool {
        self.games_played > 0
    }
}

impl Default for Player {
    /// Default constructor.
    /// Sets `name` and `username` to
    /// "UNKNOWN" and `games_played to 0.
    fn default() -> Self {
        Player {
            name: String::from("UNKNOWN"),
            username: String::from("UNKNOWN"),
            games_played: 0,
        }
    }
}

impl std::fmt::Display for Player {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}: {}, {}", self.name, self.username, self.games_played)
    }
}

fn main() {
    let name = String::from("Selena Gomeze");
    let username = String::from("Mabel Mora");
    let games_played = 15;

    let player = Player::new(name, username, games_played);

    println!("{}", player);
}
