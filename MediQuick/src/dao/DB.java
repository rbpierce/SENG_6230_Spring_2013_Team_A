package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

public class DB {
    private static final String DRIVER = "com.mysql.jdbc.Driver";

    // zeroDateTimeBehavior := Emulate mysql4 functionality- when encounter 0000-00-00, convert to a null
    // jdbcCompliantTruncation := Emulate mysql4 functionality- do not warn when data is truncated
    // useOldAliasMetadataBehavior := dbtags library matchdes on column name
    // cacheServerConfiguration := set to true so don't have to query parameters each time a query is run
    // enableQueryTimeouts := Recommended disabled for max performance

    // http://dev.mysql.com/doc/connector-j/en/connector-j-useconfigs.html "maxPerformance"
    // elideSetAutoCommits := Recommended enabled for max performance
    // alwaysSendSetIsolation := Recommended disabled for max performance
    // enableQueryTimeouts := Recommended disabled for max performance
    private final static String myopts = "?zeroDateTimeBehavior=convertToNull&jdbcCompliantTruncation=false&useOldAliasMetadataBehavior=true"
            + "&cacheServerConfiguration=true&elideSetAutoCommits=true&alwaysSendSetIsolation=false&enableQueryTimeouts=false&autoReconnect=true";

    private static String host = null;
    private static String defaultSchema = null;
    private static String username = null;
    private static String password = null;
    private static Connection conn = null;

    public static Connection getConnection() {

        try {
            if (conn != null && !conn.isClosed()) {
                return conn;
            } else {
                Properties dbProps = new Properties();
                dbProps.load(DB.class.getResourceAsStream("db.properties"));
                host = dbProps.getProperty("database.host");
                defaultSchema = dbProps.getProperty("database.default_schema");
                username = dbProps.getProperty("database.username");
                password = dbProps.getProperty("database.password");

                Class.forName(DRIVER);
                conn = DriverManager.getConnection(getURL(), username, password);
            }
        } catch (Exception e) {
            e.printStackTrace();
            conn = null;
        }
        return conn;
    }

    public static ResultSet executeQuery(String Query) {
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(Query);
            ResultSet rs = ps.executeQuery();
            return rs;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void executeUpdate(String Query) {
        try {
            conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(Query);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static String getDriver() {
        return DRIVER;
    }

    public static String getHost() {
        return host;
    }

    public static String getDefaultSchema() {
        return defaultSchema;
    }

    public static String getURL() {
        return host + "/" + defaultSchema + myopts;
    }

    public static String getUsername() {
        return username;
    }

    public static String getPassword() {
        return password;
    }

    public static Connection getConn() {
        return conn;
    }

    private static final long serialVersionUID = 1L;

    public static void INSERT(String TableName, String Columns, String Values) {
        String sql = "INSERT INTO " + TableName + " " + Columns + " VALUES " + Values;
        System.out.println(sql);
        // executeUpdate(sql);
    }
}
