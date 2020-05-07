package utilities;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.commons.dbcp2.BasicDataSource;

public class DBCPDataSource {
    // private static String URL = "jdbc:mysql://localhost:3306/polling";

    private static BasicDataSource ds = new BasicDataSource();

    static{
    	
    	ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
        ds.setUrl("jdbc:mysql://localhost:3306/polling_v2?serverTimezone=UTC");
        ds.setUsername("guest");
        ds.setPassword("");
        ds.setMaxIdle(10);
        ds.setMaxOpenPreparedStatements(100);
    }

    public static Connection getConnection() throws SQLException{
        return ds.getConnection();
    }

    // Connection con = DBCPDataSource.getConnection();
}
