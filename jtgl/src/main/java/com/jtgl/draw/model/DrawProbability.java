package com.jtgl.draw.model;

public class DrawProbability {
	
	//最小值
	public int minElement;
	//最大值
	public int maxElement;
	//奖项id
	public Integer prizeId;

	public int getMinElement() {
		return minElement;
	}

	public void setMinElement(int minElement) {
		this.minElement = minElement;
	}
	
	public int getMaxElement() {
		return maxElement;
	}

	public void setMaxElement(int maxElement) {
		this.maxElement = maxElement;
	}

	public Integer getPrizeId() {
		return prizeId;
	}

	public void setPrizeId(Integer prizeId) {
		this.prizeId = prizeId;
	}

	/** 
     * 判断当前集合是否包含特定元素 
     * @param element 
     * @return 
     */  
    public boolean isContainKey(double element){  
        boolean flag = false;  
        if(element > minElement && element <= maxElement){  
            flag = true;  
        }  
        return flag;  
    }

}
