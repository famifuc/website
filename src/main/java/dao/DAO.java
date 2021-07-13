package dao;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import entity.Product;

public class DAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	public ArrayList<Product> getAllProduct(int a, int b) {
		ArrayList<Product> list = new ArrayList<>();
		String sql = "SELECT * FROM web.product Limit ?,?";

		try {

			new DBContext();
			conn = DBContext.getMySQLConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, a);
			ps.setInt(2, b);
			rs = ps.executeQuery();

			while (rs.next()) {

				Integer id = rs.getInt("Id");
				String name = rs.getString("Name");
				Integer price = rs.getInt("Price");
				String image = rs.getString("Image");
				Product p = new Product(id, name, price, image);
				list.add(p);

			}
		} catch (Exception e) {
			e.printStackTrace();

		}

		return list;
	}
	/*
	 * public static void main(String[] args) { DAO s = new DAO();
	 * System.out.println(s.getAllProduct()); }
	 */

	public int getCount() throws ClassNotFoundException, SQLException {
		Connection conn = DBContext.getMySQLConnection();
		ArrayList<Product> list = new ArrayList();
		String sql = "SELECT count(id) FROM web.product";
		int count = 0;
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	/*
	 * public static void main(String[] args) { DAO dao = new DAO(); List<Product>
	 * list = dao.getAllProduct(); for(Product o : list) { System.out.println(o); }
	 * }
	 */
	public boolean addProduct(Product p) throws ClassNotFoundException, SQLException {
		new DBContext();
		String sql = "INSERT INTO `web`.`product` (`id`, `name`, `price`, `image`) VALUES (?, ?, ?, ?);";
		ps = DBContext.getMySQLConnection().prepareStatement(sql);
		ps.setInt(1, p.getId());
		ps.setString(2, p.getName());
		ps.setInt(3, p.getPrice());
		ps.setString(4, p.getImage());
		return ps.executeUpdate() > 0;
	}

	public boolean deleteProduct(int id) throws ClassNotFoundException, SQLException {
		String sql = "DELETE FROM `web`.`product` WHERE `id`=?";
		ps = DBContext.getMySQLConnection().prepareStatement(sql);
		ps.setInt(1, id);
		return ps.executeUpdate() > 0;
	}

	public Product getProductID(String txt) throws SQLException, ClassNotFoundException {
		/*String sql = "SELECT * FROM product WHERE id=?";
		ps = DBContext.getMySQLConnection().prepareStatement(sql);
		ps.setString(1, txt);
		rs = ps.executeQuery();
		Product p = null;
		while (rs.next()) {
			Integer id = rs.getInt("Id");
			String name = rs.getString("Name");
			Integer price = rs.getInt("Price");
			String image = rs.getString("Image");
			p = new Product(id, name, price, image);
		}
		return p; */

        String sql = "select * from product where id = ?";
        List<Product> list = new ArrayList<>();
        try {
        	ps = DBContext.getMySQLConnection().prepareStatement(sql);
            ps.setString(1, txt);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                1);
            }
        } catch (Exception e) {
        }
        return null;
	}

	public ArrayList<Product> searchProduct(String txtSearch) {
		ArrayList<Product> list = new ArrayList<>();

		String sql = "SELECT * FROM web.product WHERE name like ?";
		try {

			new DBContext();
			conn = DBContext.getMySQLConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + txtSearch + "%");
			rs = ps.executeQuery();

			while (rs.next()) {

				Integer id = rs.getInt("Id");
				String name = rs.getString("Name");
				Integer price = rs.getInt("Price");
				String image = rs.getString("Image");
				Product p = new Product(id, name, price, image);
				list.add(p);

			}
		} catch (Exception e) {
			e.printStackTrace();

		}

		return list;
	}

	/*
	 * public static void main(String[] args) { DAO dao = new DAO();
	 * System.out.println(dao.searchProduct("d")); }
	 */
	public int count(String txtSearch) {
		int c = 0;

		try {
			String sql = "SELECT count(*) FROM web.product WHERE name like?";
			new DBContext();
			conn = DBContext.getMySQLConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + txtSearch + "%");
			rs = ps.executeQuery();
			while (rs.next()) {
				c = rs.getInt(1);
			}

		} catch (Exception e) {

		}
		return c;
	}
	/*
	 * public static void main(String[] args ) { DAO dao = new DAO(); int count =
	 * dao.count("t"); System.out.println(count); }
	 */
}
