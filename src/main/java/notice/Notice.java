package notice;

public class Notice {
	private int nNum;
	private String nTitle;
	private String userID;
	private String nText;
	private String nDate;
	private int nCount;
	private int nDelete;
	
	public int getnDelete() {
		return nDelete;
	}
	public void setnDelete(int nDelete) {
		this.nDelete = nDelete;
	}
	public int getnNum() {
		return nNum;
	}
	public void setnNum(int nNum) {
		this.nNum = nNum;
	}
	public String getnTitle() {
		return nTitle;
	}
	public void setnTitle(String nTitle) {
		this.nTitle = nTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getnText() {
		return nText;
	}
	public void setnText(String nText) {
		this.nText = nText;
	}
	public String getnDate() {
		return nDate;
	}
	public void setnDate(String nDate) {
		this.nDate = nDate;
	}
	public int getnCount() {
		return nCount;
	}
	public void setnCount(int nCount) {
		this.nCount = nCount;
	}
}
