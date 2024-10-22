package model;

public class ComBo634 {
    private int ID;
    private String tenCombo;
    private double giaCombo;
    private String moTa;

    // Constructor
    public ComBo634(int ID, String tenCombo, double giaCombo, String moTa) {
        this.ID = ID;
        this.tenCombo = tenCombo;
        this.giaCombo = giaCombo;
        this.moTa = moTa;
    }

    // Getters and Setters
    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getTenCombo() {
        return tenCombo;
    }

    public void setTenCombo(String tenCombo) {
        this.tenCombo = tenCombo;
    }

    public double getGiaCombo() {
        return giaCombo;
    }

    public void setGiaCombo(double giaCombo) {
        this.giaCombo = giaCombo;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

}
