from motor.motor_asyncio import AsyncIOMotorClient
from beanie import init_beanie
from app.core.config import settings
from app.models.user import User

db_client: AsyncIOMotorClient = None


async def connect_to_mongo():
    global db_client
    db_client = AsyncIOMotorClient(settings.MONGODB_URL)
    
    await init_beanie(
        database=db_client[settings.MONGODB_DB_NAME],
        document_models=[User]
    )
    print(f"Connected to MongoDB: {settings.MONGODB_DB_NAME}")


async def close_mongo_connection():
    global db_client
    if db_client:
        db_client.close()
        print("Closed MongoDB connection")


def get_database():
    return db_client[settings.MONGODB_DB_NAME]
