class Singleton {
    private static instance: any;
    public static getInstance(): any {
        if (!Singleton.instance) {
            Singleton.instance = new Singleton();
        }
        return Singleton.instance;
    }
}

export default Singleton;
