package model;

public class MonAn634 {
    private int id;
    private String tenMon;
    private double gia;
    private String theLoai;
    private String mota;
    // Constructor không tham số
    public MonAn634() {
    }

    public MonAn634(int id, String tenMon, double gia, String theLoai, String mota) {
        this.id = id;
        this.tenMon = tenMon;
        this.gia = gia;
        this.theLoai = theLoai;
        this.mota = mota;
    }
    

    public String getMota() {
        return mota;
    }

    public void setMota(String mota) {
        this.mota = mota;
    }

    // Getters và Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTenMon() {
        return tenMon;
    }

    public void setTenMon(String tenMon) {
        this.tenMon = tenMon;
    }

    public double getGia() {
        return gia;
    }

    public void setGia(double gia) {
        this.gia = gia;
    }

    public String getTheLoai() {
        return theLoai;
    }

    public void setTheLoai(String theLoai) {
        this.theLoai = theLoai;
    }
}
